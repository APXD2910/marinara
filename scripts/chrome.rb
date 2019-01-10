require 'tmpdir'

def run_chrome(language)
  user_data_dir = Dir.mktmpdir('marinara')
  extension_dir = File.join(Dir.pwd, 'package')

  orig = `defaults read com.google.Chrome AppleLanguages 2>&1`
  if $?.success?
    languages = orig.lines.slice(1, orig.lines.length - 2).map { |s| s.strip.tr(',', ' ') }
    restore = -> { `defaults write com.google.Chrome AppleLanguages '(#{languages.join(',')})'` }
  else
    restore = -> { `defaults delete com.google.Chrome AppleLanguages` }
  end

  `defaults write com.google.Chrome AppleLanguages '("#{language}")'`

  begin
    args = [
      '--new',
      '-a',
      'Google Chrome',
      '--args',
      '--no-first-run',
      "--user-data-dir=#{user_data_dir}",
      "--load-extension=#{extension_dir}",
      'about:blank'
    ]

    puts "Running Chrome with locale #{language}."
    system('open', *args)
  ensure
    restore.call
  end
end
