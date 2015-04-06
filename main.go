/*
	Program that acts similar to cat()
	except instead of using stdout it creates
	a private gist in Github

	Uses an environment variable GITHUB_API to
	determine the users api key.
*/

package main

import (
	"bytes"
	"flag"
	"fmt"
	"io"
	"os"

	"code.google.com/p/goauth2/oauth"
	"github.com/google/go-github/github"
)

const tokenEnv = "GITHUB_API"

type GistFiles map[github.GistFilename]github.GistFile

// Create GistFiles from stdin
func FromStdin(gistFiles GistFiles, fExt string) github.GistFile {
	var stdOutBuff bytes.Buffer

	_, err := io.Copy(&stdOutBuff, os.Stdin)
	if err != nil {
		fmt.Printf("Error copying stdin to buffer: %v\n", err)
		os.Exit(1)
	}

	gistStr := stdOutBuff.String()
	return github.GistFile{Content: &gistStr}
}

// Cats file content together into a gistFile
func FromFiles(gistFiles GistFiles, files []string, fExt string) github.GistFile {
	var stdOutBuff bytes.Buffer

	for _, fileName := range files {
		file, err := os.Open(fileName)
		if err != nil {
			fmt.Printf("Error opening file %s: %v", fileName, err)
			os.Exit(1)
		}

		if _, err := io.Copy(&stdOutBuff, file); err != nil {
			fmt.Printf("Error copying file contents to buffer: %v\n", err)
		}
	}

	gistStr := stdOutBuff.String()
	return github.GistFile{Content: &gistStr}
}

func main() {
	var public = flag.Bool("public", false, "makes the gist public")
	var extension = flag.String("ext", "txt", "file extension to use")
	flag.Parse()

	apiToken := os.Getenv(tokenEnv)
	if apiToken == "" {
		fmt.Println("must set environment variable $GITHUB_API")
		os.Exit(1)
	}

	t := &oauth.Transport{
		Token: &oauth.Token{AccessToken: apiToken},
	}
	client := github.NewClient(t.Client())

	args := flag.Args()
	gistFiles := make(GistFiles)
	gistFilename := github.GistFilename(fmt.Sprintf("gistfile1.%s", *extension))
	if len(args) == 0 {
		gistFiles[gistFilename] = FromStdin(gistFiles, *extension)
	} else {
		gistFiles[gistFilename] = FromFiles(gistFiles, args, *extension)
	}

	gist := github.Gist{
		Files:  gistFiles,
		Public: public,
	}

	g, _, err := client.Gists.Create(&gist)
	if err == nil {
		fmt.Printf("New gist created: %s\n", *g.HTMLURL)
		os.Exit(0)
	} else {
		fmt.Printf("Error creating new gist: %v\n", err)
		os.Exit(1)
	}
}
