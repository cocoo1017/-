# tab 07 - 箱型圖

tabItem(
  tabName = 'page07_boxplot',
  fluidRow(
    box(
      width = 4 ,
      headerBorder = FALSE,
      collapsible = FALSE,
      tabsetPanel(
        # 變數分頁
        tabPanel(
          '變數',
          # 選擇分組(x軸)變數(類別)
          uiOutput('page07_ui_discrete_x_select1'),
          # 選擇y軸變數(連續)
          uiOutput('page07_ui_continuous_select1')
        ),
        # 外觀分頁
        tabPanel(
          '外觀',
          h6('輸入標題:', style = 'font-Weight:bold; font-size:16px;'),
          # 圖標題
          textInput('page07_ui_title_text1', label = '圖標題', value = '箱型圖'),
          splitLayout(
            # X軸標題
            uiOutput('page07_ui_x_title_text1'),
            # Y軸標題
            uiOutput('page07_ui_y_title_text1')
          ),
          # 字體尺寸設定
          h6('字體尺寸:', style = 'font-Weight: bold; font-size: 16px;'),
          # 選擇圖標題字體尺寸
          numericInput('page07_ui_title_num1', label = '圖標題', value = 20),
          splitLayout(
            # 選擇軸標題字體尺寸
            numericInput(
              'page07_ui_axis_title_num1',
              label = HTML(
                '軸標題',
                as.character(actionLink(
                  'page07_actionLink_axis_title',
                  label = '',
                  icon = icon(name = 'question-circle', lib = 'font-awesome', 'fa-xs')
                )
                )
              ),
              value = 15
            ),
            # 選擇軸標籤字體尺寸
            numericInput(
              'page07_ui_axis_label_num1',
              label = HTML(
                '軸標籤',
                as.character(actionLink(
                  'page07_actionLink_axis_label',
                  label = '',
                  icon = icon(name = 'question-circle', lib = 'font-awesome', 'fa-xs')
                )
                )
              ),
              value = 10
            )
          ),
          # 選擇軸標籤角度
          sliderInput(
            'page07_ui_axis_angle_slider1',
            label = '軸標籤角度:',
            min = 0,
            max = 90,
            value = 90
          ),
          # 顏色
          checkboxInput('page07_colours_check1', label = '自訂顏色'),
          uiOutput('page07_colours'),
          # 離群值外觀
          checkboxInput('page07_outlier_check1', label = '自訂離群值外觀'),
          numericInput(
            'page07_ui_outlier_num1',
            label = '點尺寸',
            value = 1
          ),
          uiOutput('page07_outlier_colour'),
          splitLayout(
            # 下載圖片的寬
            numericInput(
              'page07_ui_download_width_num1',
              label = '寬(下載):',
              value = 600
            ),
            # 下載圖片的高
            numericInput(
              'page07_ui_download_height_num1',
              label = '高(下載):',
              value = 400
            )
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
        plotOutput('page07_boxplot', height = '100%'),
        color = '#0dc5c1'
      ),
      # 下載
      column(12, align = 'right', downloadButton('downloadPlot_7', '下載'))
    )
  )
)