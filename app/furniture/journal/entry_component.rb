class Journal
  class EntryComponent < ApplicationComponent
    include RendersMarkdown
    attr_accessor :entry

    def initialize(*args, entry:, **kwargs)
      self.entry = entry
      super(*args, **kwargs)
    end

    def body_html
      postprocess(render_markdown(entry.body))
    end

    private def postprocess(text)
      entry.keywords.map do |keyword|
        replace_keyword(text, keyword)
      end

      text
    end

    private def replace_keyword(text, keyword)
      text.gsub!(keywords_regex(keyword)) do |match|
        link_to(match, keyword.location)
      end
    end

    # We sort the keywords longest to shortest because regex matches groups left-to-right
    private def keywords_regex(keyword)
      /\#(#{keyword.canonical_with_aliases.sort.reverse.join("|")})/i
    end

    private def published_at
      entry.published_at.to_fs(:long_ordinal)
    end

    def self.renderer
      @_renderer ||= Redcarpet::Markdown.new(
        Renderer.new(filter_html: true, with_toc_data: true),
        autolink: true, strikethrough: true,
        no_intra_emphasis: true,
        lax_spacing: true,
        fenced_code_blocks: true, disable_indented_code_blocks: true,
        tables: true, footnotes: true, superscript: true, quote: true
      )
    end
  end
end