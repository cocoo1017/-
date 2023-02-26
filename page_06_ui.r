# tab 06 - 圓餅圖
tabItem(
  tabName = 'page06_piechart',
  fluidRow(
    box(
      width = 4 ,
      headerBorder = FALSE,
      collapsible = FALSE,
      # 分頁
      tabsetPanel(
        tabPanel(
          '變數',
          # 選擇主要變數(連續)
          uiOutput('page06_ui_continuous_select1'),
          # 選擇分組變數(類別)
          uiOutput('page06_ui_discrete_select1')
        ),
        tabPanel(
          '外觀',
          h6('輸入標題:', style = 'font-Weight:bold; font-size:16px;'),
          # 圖標題
          textInput('page06_ui_title_text1', label = '圖標題', value = '圓餅圖'),
          # 主要變數(X軸)標題
          uiOutput('page06_ui_x_title_text1'),
          h6('字體尺寸:', style = 'font-Weight:bold; font-size:16px;'),
          # 選擇圖標題字體尺寸
          numericInput('page06_ui_title_num1', label = '圖標題', value = 20),
          splitLayout(
            #選擇軸標題字體尺寸
            numericInput(
              'page06_ui_axis_title_num1',
              label = HTML(
                '主要變數標題',
                as.character(actionLink(
                  'page06_actionLink_axis_title',
                  label = '',
                  icon = icon(name = 'question-circle', lib = 'font-awesome', 'fa-xs')
                )
                )
              ),
              value = 15
            ),
            # 選擇軸標籤字體尺寸
            numericInput(
              'page06_ui_axis_label_num1',
              label = HTML(
                '標籤',
                as.character(actionLink(
                  'page06_actionLink_axis_label',
                  label = '',
                  icon = icon(name = 'question-circle', lib = 'font-awesome', 'fa-xs')
                  )
                )
              ),
              value = 10
            )
          ),
          # 顏色
          checkboxInput('page06_colours_check1', label = '自訂顏色'),
          uiOutput('page06_colours'),
          splitLayout(
            # 下載圖片的寬
            numericInput('page06_ui_download_width_num1', label = '寬(下載):', value = 600),
            # 下載圖片的高
            numericInput('page06_ui_download_height_num1', label = '高(下載):', value = 400)
          )
        )
      ) 
    ),
    box(
      width = 8 ,
      headerBorder = FALSE,
      collapsible = FALSE,
      # loading 圖示
      withSpinner(
        plotOutput('page06_piechart', height = '100%'),
        color = '#0dc5c1'),
      # 下載
      column(12, align = 'right', downloadButton('downloadPlot_6', '下載'))
    )
  )
)
