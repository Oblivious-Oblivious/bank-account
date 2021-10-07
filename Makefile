NAME = bank-account
INPUT = $(NAME).rb

run:
	ruby app/src/$(INPUT)

test:
	ruby database/spec/user_saver.spec.rb \
		 database/spec/UserDescriptor.spec.rb \
		 client/spec/Presenter.spec.rb \
		 client/spec/ViewModel.spec.rb \
		 app/spec/$(NAME).spec.rb

test_app:
	ruby app/spec/$(NAME).spec.rb

test_client:
	ruby client/spec/Presenter.spec.rb \
		 client/spec/ViewModel.spec.rb

test_db:
	ruby database/spec/user_saver.spec.rb \
		 database/spec/UserDescriptor.spec.rb

clean:
	@echo
