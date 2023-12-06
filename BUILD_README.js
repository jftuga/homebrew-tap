/*
BUILD_README.js
-John Taylor
2023-12-06

Automatically generate a README.md file for this repo which includes
hyperlinks to source repositories and their descriptions

Usage: node BUILD_README.js

Acknowledgements: ChatGPT :-)
*/

const fs = require('fs').promises;
const OUTPUT_FILE = "README.md"
const MARKDOWN_HEADER = `
# homebrew-tap
Homebrew tap for jftuga command-line tools

## Install:
* \`brew update; brew install jftuga/tap/XYZ\`  <-- where \`XYZ\` is a package name such as: awswho, ipinfo, etc.

## Programs
`

function getGlob(ext) {
    return fs.readdir(".")
        .then(files => {
            const matchedFiles = files.filter(file => file.endsWith(ext));
            //matchedFiles.forEach(file => console.log(file));
            return matchedFiles;
        })
        .catch(err => {
            console.error(err);
            throw err; // Re-throw the error to propagate it
        });
}

function extractTextBetweenQuotes(inputString) {
    const regex = /"([^"]*)"/;
    const match = inputString.match(regex);

    // If a match is found, return the text between double quotes
    // The captured group ([^"]*) contains the text between the quotes
    return match ? match[1] : null;
}

function searchFileForString(filePath, allSearchStrings) {
    return fs.readFile(filePath, 'utf8')
        .then(data => {
            results = {}
            const lines = data.split('\n');
            for (const line of lines) {
                for (const searchString of allSearchStrings) {
                    homeBrewSearchString1 = `  ${searchString} "`;
                    homeBrewSearchString2 = `${searchString} `;
                    if (line.includes(homeBrewSearchString1)) {
                        results[searchString] = extractTextBetweenQuotes(line);
                    } else if (line.includes(homeBrewSearchString2) && searchString === "class") {
                        results[searchString] = line.split(" ")[1].toLocaleLowerCase();
                    }
                    if (allSearchStrings.length === Object.keys(results).length) {
                        break;
                    }
                }
            }
            return results;
        })
        .catch(err => {
            console.error(err);
            throw err; // Re-throw the error to propagate it
        });
}

function getMetadata(filePath, allSearchStrings) {
    return searchFileForString(filePath, allSearchStrings)
        .then(found => {
            //console.log(found);
            return found;
        })
        .catch(err => {
            // Handle errors from the promise chain
            console.error("Error in promise chain:", err);
        });
}

function createMarkdownEntry(metadata) {
    return `* [${metadata["class"]}](${metadata["homepage"]}) - ${metadata["desc"]}`
}

function saveMarkDownFile(filename, lines) {
    const fsw = require('fs');
    const stream = fsw.createWriteStream(filename, { flags: 'w' });

    stream.write(MARKDOWN_HEADER + "\n\n");

    lines.forEach(line => {
        stream.write(line + '\n');
    });
    stream.end();
}

function getCurrentDateTime() {
    const now = new Date();

    const year = now.getFullYear();
    const month = (now.getMonth() + 1).toString().padStart(2, '0');
    const day = now.getDate().toString().padStart(2, '0');
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');
    const seconds = now.getSeconds().toString().padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}


function main() {
    getGlob('.rb')
        .then(matchedFiles => {
            //console.log(matchedFiles);            
            const metadataPromises = matchedFiles.map(file => {
                return getMetadata(file, [`class`, `desc`, `homepage`])
                    .then(metadata => createMarkdownEntry(metadata));
            });
            return Promise.all(metadataPromises);
        })
        .then(allMarkdownEntries => {
            saveMarkDownFile(OUTPUT_FILE, allMarkdownEntries);
            console.log("\n");
            console.log("Program entries:");
            console.log(allMarkdownEntries);
            console.log("\n");
            console.log("Creating markdown file:", OUTPUT_FILE, "\n")
            console.log(`git commit ${OUTPUT_FILE} -m "generated on: ${getCurrentDateTime()}"; git push\n`);
            return allMarkdownEntries;
        })
        .catch(err => {
            // Handle errors from the promise chain
            console.error("Error in promise chain:", err);
        });
}

main();
