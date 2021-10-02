NAME = bank-account
INPUT = $(NAME).rb

run:
	ruby app/src/$(INPUT)

test:
	ruby app/spec/$(NAME).spec.rb

test_db:
	ruby database/spec/user_saver.spec.rb \
		 database/spec/UserDescriptor.spec.rb

clean:
	@echo

# TODO Create a Register use case and friends
