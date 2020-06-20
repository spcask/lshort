*.tex: clean checks
	make build FILE="$@"
	FILE="$@"; make open FILE="$${FILE%.tex}.pdf"
	make clean

build:
	pdflatex "$(FILE)"
	pdflatex "$(FILE)"

open:
	if command -v xdg-open > /dev/null; then \
	    xdg-open "$(FILE)"; \
	elif command -v open > /dev/null; then \
	    open "$(FILE)"; \
	else \
	    echo Cannot find xdg-open or open; \
	fi

clean:
	rm -rf *.aux *.log *.toc

checks:
	# Ensure that number of examples matches the maximum example number.
	items=$$(ls -1 [0-9][0-9]* | grep -v '\.pdf' | sort -n); \
	m=$$(printf '%s\n' "$$items" | wc -l); \
	n=$$(printf '%s\n' "$$items" | tail -n 1 | cut -d- -f1); \
	echo examples: $$m; \
	echo max item: $$n; \
	[ $$n -eq $$m ]
