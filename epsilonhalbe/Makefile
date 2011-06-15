all :
	ghc --make -Wall Mastermind.hs

clean :
	rm -f Mastermind tMastermind *.hi *.o report.html

test :
	ghc --make -Wall tMastermind.hs
	./tMastermind

prove :
# cpan App::Prove
	prove --exec make test


provehtml :
# cpan App::Prove::Plugin::HTML
	prove -P HTML=outfile:report.html --exec make test
