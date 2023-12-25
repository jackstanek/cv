build:
    mkdir -p .cache/texmf-var;
    env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
      latexmk -interaction=nonstopmode -pdf -lualatex -outdir=build \
      {{env_var('DOCNAME')}}.tex

clean:
    rm -rf build/
