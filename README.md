This a demonstration of one step transformation of C native image (`registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-c`) to SCONE-enabled image (`hello-world-c-scone`).

Execute `sconify.sh` to sconify the native c image.

`sconify.sh` leverages `sconify_image` container that takes an input native image `--from` (`--from=registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-c`) and transform it to `--to` (`--to=hello-world-c-scone \`).
All other option related to the `sconify_image` tool could be obtained by running
```
docker run -it --rm  registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-latest
```

To run the the sconified image, execute `run.sh`
