# tab 05 - 直方圖
tabItem(
  tabName = 'page05_histogram',
  fluidRow(
    box(
      width = 4 ,
      headerBorder = FALSE,
      collapsible = FALSE,
      # 分頁
      tabsetPanel(
        tabPanel(
          '變數',
          # 選擇x軸變數(連續)
          uiOutput('page05_ui_continuous_x_select1'),
          # 選擇組數
          numericInput(
            'page05_ui_bins_num1',
            label = HTML(
              '組數',
              as.character(
                actionLink(
                  'page05_actionLink_bins',
                  label = '',
                  icon = icon(name = 'question-circle', lib = 'font-awesome', 'fa-xs')
                )
              )
            ),
            value = 30
            )
        ),
        tabPanel(
          '外觀',
          h6('輸入標題:', style = 'font-Weight:bold; font-size:16px;'),
          # 圖標題
          textInput('page05_ui_title_text1', label = '圖標題', value = '直方圖'),
          splitLayout(
            # X軸標題
            uiOutput('page05_ui_x_title_text1'),
            # Y軸標題
            textInput(
              'page05_y_title_text1',
              label = 'Y軸標題',
              value = '次數'
            )
          ),
          h6('字體尺寸:', style = 'font-Weight:bold; font-size:16px;'),
          # 選擇圖標題字體尺寸
          numericInput('page05_ui_title_num1', label = '圖標題', value = 20),
          splitLayout(
            #選擇軸標題字體尺寸
            numericInput(
              'page05_ui_axis_title_num1',
              label = '軸標題',
              value = 15
            ),
            #選擇軸標籤字體尺寸
            numericInput(
              'page05_ui_axis_label_num1',
              label = '軸標籤',
              value = 10
            )
          ),
          #選擇軸標籤角度
          sliderInput(
            'page05_ui_axis_angle_slider1',
            label = '軸標籤角度:',
            min = 0,
            max = 90,
            value = 0
          ),
          # 顏色
          checkboxInput('page05_colours_check1', label = '自訂顏色'),
          uiOutput('page05_ui_colours_fill'),
          uiOutput('page05_ui_colours_colour'),
          splitLayout(
            # 下載圖片的寬
            numericInput('page05_ui_download_width_num1', label = '寬(下載):', value = 600),
            # 下載圖片的高
            numericInput('page05_ui_download_height_num1', label = '高(下載):', value = 400)
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
        plotOutput('page05_histogram', height = '100%'),
        color = '#0dc5c1'),
      # 下載
      column(12, align = 'right', downloadButton('downloadPlot_5', '下載'))
    )
  )
)
