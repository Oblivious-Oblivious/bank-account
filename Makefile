run:
	ruby app/src/bank-account.rb

run_cli:
	ruby client/cli/View.rb

test:
	ruby database/spec/user_saver.spec.rb \
		 database/spec/UserDescriptor.spec.rb \
		 client/spec/Presenter.spec.rb \
		 client/spec/ViewModel.spec.rb \
		 app/spec/spec_helper.rb

test_app:
	ruby app/spec/spec_helper.rb

test_client:
	ruby client/spec/Presenter.spec.rb \
		 client/spec/ViewModel.spec.rb

test_db:
	ruby database/spec/user_saver.spec.rb \
		 database/spec/UserDescriptor.spec.rb

clean:
	@echo
