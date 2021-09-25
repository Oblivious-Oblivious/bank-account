NAME = bank-account
INPUT = $(NAME).rb

run:
	ruby src/$(INPUT)

test:
	ruby spec/$(NAME).spec.rb

clean:
	@echo
