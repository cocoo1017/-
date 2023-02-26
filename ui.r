# UI
dashboardPage(
  # 標題
  header = dashboardHeader(
    title = "視覺化工具網站"
  ),
  # 側邊選單
  sidebar = dashboardSidebar(
    sidebarMenu(
      # tab 01 - 資料
      menuItem(
        "資料", 
        tabName = "page01_data",
        icon = icon(name = "database", lib = "font-awesome")
      ),
      # tab 02 - 散佈圖
      menuItem(
        # font-awesome 沒有散佈圖，因此只能用圖片
        span(
          img(
            src = "scatter-chart.png", 
            height = "20px", width = "20px",
            style = "margin-left: 3px; margin-right: 7px"
          ),
          "散佈圖"
        ),
        tabName = "page02_scatter"
      ),
      # tab 03 - 長條圖
      menuItem(
        "長條圖", 
        tabName = "page03_barChart",
        icon = icon(name = "chart-bar", lib = "font-awesome") 
      ),
      # tab 04 - 折線圖
      menuItem(
        "折線圖", 
        tabName = "page04_lineChart" ,
        icon = icon(name = "chart-line", lib = "font-awesome")
      ),
      # tab 05 - 直方圖
      menuItem(
        "直方圖", 
        tabName = "page05_histogram" ,
        icon = icon(name = "chart-bar", lib = "font-awesome")
      ),
      # tab 06 - 圓餅圖
      menuItem(
        "圓餅圖", 
        tabName = "page06_piechart" ,
        icon = icon(name = "chart-pie", lib = "font-awesome")
      ),
      # tab 07 - 箱型圖
      menuItem(
        "箱型圖", 
        tabName = "page07_boxplot" ,
        icon = icon(name = "box", lib = "font-awesome")
      )
    ),
  skin = "light",
  minified = FALSE
  ),
  # 主要頁面
  body = dashboardBody(
    tabItems(
      # tab 01 - 資料
      source("./page_01_ui.r", encoding = "utf-8", local = T)$value ,
      # tab 02 - 散佈圖
      source("./page_02_ui.r", encoding = "utf-8", local = T)$value ,
      # tab 03 - 長條圖
      source("./page_03_ui.r", encoding = "utf-8", local = T)$value ,
      # tab 04 - 折線圖
      source("./page_04_ui.r", encoding = "utf-8", local = T)$value ,
      # tab 05 - 直方圖
      source("./page_05_ui.r", encoding = "utf-8", local = T)$value ,
      # tab 06 - 圓餅圖
      source("./page_06_ui.r", encoding = "utf-8", local = T)$value ,
      # tab 07 - 箱型圖
      source("./page_07_ui.r", encoding = "utf-8", local = T)$value
    )
  ),
  # 頁尾
  footer = dashboardFooter(
    left = 'Team C 學員：林書羽、劉宸宇', 
    right = '業師：唐子鈞'
  )
)


