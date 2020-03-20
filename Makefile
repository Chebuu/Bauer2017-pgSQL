SHELL = /bin/bash

views: lib/*.sql
	bash bin/build-views.sh \
		-h $(or $(PGHOST), false) \
		-p $(or $(PGPORT), false) \
		-d "mimic" \

features: clinical-features/*.sql demographics/*.sql severity-scores/*.sql
	bash bin/build-features.sh \
		-h $(or $(PGHOST), false) \
		-p $(or $(PGPORT), false) \
		-d "mimic" 

cohort: cohort.sql
	make clean-log
	bash bin/build-cohort.sh \
		-h $(or $(PGHOST), false) \
		-p $(or $(PGPORT), false) \
		-d "mimic"

build:
	make views
	make cohort
	make features

export-cohort:
	bash bin/export-cohort.sh \
		-h $(or $(PGHOST), false) \
		-p $(or $(PGPORT), false) \
		-d "mimic"

export-features:
	bash bin/export-features.sh \
		-h $(or $(PGHOST), false) \
		-p $(or $(PGPORT), false) \
		-d "mimic"
export:
	make export-cohort
	make export-features
	
all:
	make build
	make export

clean:
	read -p "Do you want to delete all files in data/cohort-build [Y/n]?"  ures
	case $ures in
		[Yy]) 
			rm -rf data/cohort-build 
			&& mkdir data/cohort-build
			&& exit 0; break;;
		*) 
			echo "No action taken. Please enter Yes or no."
			exit 0;;
	esac
	exit 1

clean-log:
	cat log-head.txt > make-build.log
	