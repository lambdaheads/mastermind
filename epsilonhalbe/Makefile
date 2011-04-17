all :
	ghc --make -Wall Mastermind.hs

clean :
	rm -f Mastermind mm.t *.hi *.o report.html

test :
	ghc --make -Wall mm.t.hs
	./mm.t

prove :
# cpan App::Prove
	prove --exec make test


provehtml :
# cpan App::Prove::Plugin::HTML
	prove -P HTML=outfile:report.html --exec make test
