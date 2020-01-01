Jekyll::Hooks.register :documents, :pre_render do |document, payload|
  docExt = document.extname.tr('.', '')
  # only process if we deal with a markdown file
  if payload['site']['markdown_ext'].include? docExt
    newContent = document.content.gsub(/!\[(.*)\]\(([^\)]+)\)(?:{:([^}]+)})*/, '<div class="img-container">{% cloudinary \2 alt="\1" %}</div>')
    document.content = newContent
  end
end