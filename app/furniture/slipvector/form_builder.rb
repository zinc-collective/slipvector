class Slipvector
  class FormBuilder < ActionView::Helpers::FormBuilder
    delegate :tag, :safe_join, to: :@template

    def text_field(attribute, options = {}, hint: nil)
      safe_join(
        [
          label(attribute),
          super(attribute, options),
          (tag.small(hint) if hint.present?)
        ].compact
      )
    end
  end
end
