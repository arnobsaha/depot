module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    #This code uses the Rails standard helper, content_tag, which can be used to
    #wrap the output created by a block in a tag. By using the &block notation, we
    #get Ruby to pass the block that was given to hidden_div_if down to content_tag.

    content_tag("div", attributes, &block)
  end

end
