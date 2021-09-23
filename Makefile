NAME = bank-account
INPUT = $(NAME).cr
OUTPUT = bank

all: build

remake_export:
	$(RM) -r export
	mkdir export

build: remake_export
	crystal build --release src/$(INPUT) -o export/$(OUTPUT)

run:
	crystal run src/$(INPUT)

test:
	crystal spec ./spec/$(NAME).spec.cr

document:
	$(RM) -r ./docs
	crystal docs src/*.cr

clean:
	$(RM) -r ./export
