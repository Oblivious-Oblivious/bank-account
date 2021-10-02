NAME = bank-account
INPUT = $(NAME).rb

run:
	ruby app/src/$(INPUT)

test:
	ruby database/spec/user_saver.spec.rb \
		 database/spec/UserDescriptor.spec.rb \
		 app/spec/$(NAME).spec.rb
	ruby database/_reset.rb

test_app:
	ruby app/spec/$(NAME).spec.rb
	ruby database/_reset.rb

test_db:
	ruby database/spec/user_saver.spec.rb \
		 database/spec/UserDescriptor.spec.rb
	ruby database/_reset.rb

clean:
	@echo
