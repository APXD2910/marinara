# Create Chrome extension package (.zip).
package: validate-messages marinara/src/Messages.js
	ruby -Iscripts scripts/make-package.rb

marinara/src/Messages.js: package/_locales/en/messages.json
	ruby -Iscripts scripts/create-messages.rb "$<" > marinara/src/Messages.js

# Run Chrome with a new (temporary) user profile with Marinara loaded.
run:
	ruby -Iscripts scripts/run.rb

# Run Chrome under a different locale.
run-loc:
	ruby -Iscripts scripts/run-localized.rb

# Run Chrome with psuedo-localized messages.
run-pseudo:
	ruby -Iscripts scripts/run-pseudo-localized.rb

# Sanity check all messages.json files.
validate-messages:
	ruby -Iscripts scripts/validate-messages.rb

# Show and copy descriptions for Chrome Web Store.
show-descriptions:
	ruby -Iscripts scripts/show-descriptions.rb
