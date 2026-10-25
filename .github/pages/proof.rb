require "html-proofer"

# html-proofer 4+ dropped HTML validation, so this reports the HTML5 parse errors its parser already collects.
class HtmlParse < HTMLProofer::Check
  def run
    @html.errors.each { |error| add_failure(error.message.lines.first.strip, line: error.line) }
  end
end

HTMLProofer.check_directory(
  "_site",
  checks: ["Links", "Images", "Scripts", "HtmlParse"],
  # Third-party hosts rate-limit and time out, which would make every PR flaky.
  disable_external: true,
  # Google's site-verification token: its exact plain-text body is required, so it can never be valid HTML.
  ignore_files: [/googlea01e0bd739ed7cb5/],
).run
