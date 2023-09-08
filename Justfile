build:
            mkdir -p .cache/texmf-var;
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              latexmk -interaction=nonstopmode -pdf -lualatex \
              {{env_var('DOCNAME')}}.tex
