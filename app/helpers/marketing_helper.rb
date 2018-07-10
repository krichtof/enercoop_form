module MarketingHelper
  def situation_options
    [
      [User.situations[:move_in], 'I move in'],
      [User.situations[:new_house], 'I buit a new flat/house'],
      [User.situations[:temporary_access], 'I need a temporary access'],
    ]
  end
end
