all:
	rm -rf  logfiles *_service include *~ */*~ */*/*~;
	rm -rf *.beam src/*.beam test_src/*.beam erl_crash.dump */erl_crash.dump */*/erl_crash.dump;
	cp src/*.app ebin;
	erlc -I ../include -o ebin src/*.erl;
doc_gen:
	rm -rf  node_config logfiles doc/*;
	erlc ../doc_gen.erl;
	erl -s doc_gen start -sname doc

test:
	rm -rf  *_service include logfiles app_config node_config latest.log;
	rm -rf *.beam src/*.beam test_src/*.beam ebin/* test_ebin/* erl_crash.dump;
#	node_config
	git clone https://github.com/joq62/node_config.git;
#	catalog
#	git clone https://github.com/joq62/catalog.git;
#	app_config
	git clone https://github.com/joq62/app_config.git;
#	include
	git clone https://github.com/joq62/include.git;
#	log_service
	git clone https://github.com/joq62/log_service.git;	
	cp log_service/src/*.app log_service/ebin;
	erlc -I include -o log_service/ebin log_service/src/*.erl;
#	dns_service
	git clone https://github.com/joq62/dns_service.git;	
	cp dns_service/src/*.app dns_service/ebin;
	erlc -I include -o dns_service/ebin dns_service/src/*.erl;
	cp src/*app ebin;
	erlc -I include -o ebin src/*.erl;
	erlc -I include -o test_ebin test_src/*.erl;
	erl -pa ebin -pa */ebin -pa test_ebin -s oam_service_tests start -sname oam_test
