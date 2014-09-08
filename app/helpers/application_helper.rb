module ApplicationHelper
  def bootstrap_alert_class_for_flash type
    case type
      when 'success'
        'alert-success'
      when 'error'
        'alert-danger'
      when 'alert'
        'alert-warning'
      when 'notice'
        'alert-info'
      else
        type.to_s
    end
  end

  def errors_for model, attr_sym
    return nil unless errors_for? model, attr_sym
    render partial: '/field_errors', locals: {errors: model.errors[attr_sym]}
  end

  def errors_for? model, attr_sym
    model.errors[attr_sym].nil? or model.errors[attr_sym].size == 0 ? false : true
  end
end
