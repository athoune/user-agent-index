all: regexes.yaml build/my-languages.so

regexes.yaml:
	curl -O https://raw.githubusercontent.com/ua-parser/uap-core/master/regexes.yaml

vendor/tree-sitter-regex/src/parser.c:
	git submodule init

# It's ok if the name is .so on MacOS too, the tool builds a dynlib with an universal name
build/my-languages.so: vendor/tree-sitter-regex/src/parser.c
	poetry run ./build-parser.py

test:
	poetry run pytest --cov

clean:
	rm regexes.yaml
	rm -rf build
