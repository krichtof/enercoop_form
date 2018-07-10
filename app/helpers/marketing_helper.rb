module MarketingHelper
  def situation_options
    [
      [User.situations[:move_in], 'I move in'],
      [User.situations[:new_house], 'I buit a new flat/house'],
      [User.situations[:temporary_access], 'I need a temporary access'],
    ]
  end

  def step_classes(form, options)
    css_classes = ['form-steps__step']
    css_classes.push('form-steps__step--completed') if options[:completed]
    css_classes.push('form-steps__step--last') if options[:last]
    css_classes.push('form-steps__step--active') if options[:active]
    css_classes.push(form.class)
    css_classes.join(' ')
  end
end
