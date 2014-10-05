module NavItemHelper
  def nav_item_chat alignment
    ("<a href='/pods' class='btn btn-default btn-#{alignment}'>" +
     "<i class='fa fa-comments'></i></a>").html_safe
  end

  def nav_item_discover alignment
    ("<a href='/pools' class='btn btn-default btn-#{alignment}'>" +
     "<i class='fa fa-search'></i></a>").html_safe
  end

  def nav_item_events alignment
    ("<a href='/' class='btn btn-default btn-#{alignment}'>" +
     "<i class='fa fa-user'></i></a>").html_safe
  end
end
