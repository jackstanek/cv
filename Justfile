build:
    mkdir -p .cache/texmf-var;
    env TEXMFHOME={{justfile_directory()}}/.cache TEXMFVAR={{justfile_directory()}}/.cache/texmf-var \
      latexmk -interaction=nonstopmode -pdf -lualatex -outdir=build \
      {{env_var('DOCNAME')}}.tex

clean:
    rm -rf build/
