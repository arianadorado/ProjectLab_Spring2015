module ApplicationHelper

  def complete_button(task)
    if task.complete?
      link_to fa_icon('thumbs-o-up'), complete_path(task), remote: true, class: 'btn btn-primary btn-xs'
    else
      link_to fa_icon('thumbs-o-down'), complete_path(task), remote: true, class: 'btn btn-default btn-xs'
    end
  end

  def time_left(task)
    if task.complete?
      "Completed!"
    else
      distance_of_time_in_words_to_now(task.due_date)
    end
  end

end
