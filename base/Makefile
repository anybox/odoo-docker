.PHONY: init style complexity format test test-unit test-functional test-integration security-sast run stop destroy watch build update
.DEFAULT_GOAL := help

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

init: ## Bootstrap your application. e.g. fetch some data files, make some API calls, request user input etc...
	docker-compose up -d db
	docker-compose exec -T -u postgres db sh -c "while ! psql -U postgres -d postgres -c 'select 1' ; do echo 'Waiting pgsql init...'; sleep 1; done;"
	docker-compose exec -T -u postgres db createuser -d odoo
	docker-compose exec -T -u postgres db createdb -O odoo odoo
	docker-compose run --rm odoo /srv/odoo/odoo.py -d odoo	-i base --stop-after-init
	docker-compose down

#style: ## Check lint, code styling rules. e.g. pylint, phpcs, eslint, style (java) etc ...

#complexity: ## Cyclomatic complexity check (McCabe), radon (python), eslint (js), PHPMD, rules (scala) etc ...

#format: ## Format code. e.g Prettier (js), format (golang)

test: ## Shortcut to launch all the test tasks (unit, functional and integration).
	docker-compose up -d db
	docker-compose exec -T -u postgres db sh -c "while ! psql -U odoo -d odoo -c 'select 1' ; do echo 'Waiting pgsql init...'; sleep 1; done;"
	docker-compose run --rm odoo /srv/odoo/odoo.py -d odoo --test-enable --stop-after-init 2>&1 | tee test.log
	docker-compose down

#test-unit: ## Launch unit tests. e.g. pytest, jest (js), phpunit, JUnit (java) etc ...

#test-functional: ## Launch functional tests. e.g behat, JBehave, Behave, CucumberJS, Cucumber etc...

#test-integration: ## Launch integration tests. e.g. pytest, jest (js), phpunit, JUnit (java) etc ...

#security-sast: ## launch static application security testing (SAST). e.g Gosec, bandit, Flawfinder, NodeJSScan, phpcs-security-audit, brakeman etc...

run: ## Locally run the application, e.g. node index.js, python -m myapp, go run myapp etc ...
	docker-compose up -d

stop: ## Stop the application
	docker-compose stop

destroy: ## Destroy the application and data
	docker-compose down -v

#watch: ## Hot reloading for development.

build: ## Build the application.
	docker-compose build

update: ## Update project (step added by Anybox)
	docker-compose run --rm odoo update_project -d odoo


define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT
