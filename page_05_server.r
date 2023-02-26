### page 05 - 直方圖

## x軸變數
output$page05_ui_continuous_x_select1 <- renderUI({
  # 選項
  choices_x_05 = colTypeData()$cont
  names(choices_x_05) = colTypeData()$label_cont
  selectInput(
    'page05_continuous_x_select1',
    label = labelWithInfo('X 軸變數 (連續型)', 'page05_actionLink_continuous_x'),
    choices = choices_x_05
  )
})
## 說明視窗(x軸)
observeEvent(input$page05_actionLink_continuous_x, {
  shinyalert(
    text = '請選擇欲呈現於X軸之連續變數。'
  )
})

## x軸標題
output$page05_ui_x_title_text1 <- renderUI({
  index_05_X = grep(input$page05_continuous_x_select1, colnames(data()))
  default_05_X = colTypeData()$label[index_05_X]
  textInput(
    'page05_x_title_text1',
    label = 'X軸標題',
    value = default_05_X
  )
})

## Y軸標題
output$page05_ui_y_title_text1 <- renderUI({
  textInput(
    'page05_y_title_text1',
    label = 'Y軸標題',
    value = '次數'
  )
})

## 說明視窗(組數) 
observeEvent(input$page05_actionLink_bins, {
  shinyalert(#animation = 'slide-from-bottom',
    text = '請選擇X軸變數欲分組數。(顯示直方數)'
  )
})

## 顏色
output$page05_ui_colours_fill <- renderUI({
  req(input$page05_colours_check1)
  colourInput(
    'page05_colours_fill',
    label = '直方顏色',
    palette = 'square',
    value = '#00BFC4'
  )
})

output$page05_ui_colours_colour <- renderUI({
  req(input$page05_colours_check1)
  colourInput(
    'page05_colours_colour',
    label = '直方外框顏色',
    palette = 'square',
    value = '#00BFC4'
  )
})

## 直方圖
observe({
  output$page05_histogram <- renderPlot({
    # 檢核
    req(input$page05_continuous_x_select1)
    
    # 判斷是否自訂顏色
    if (input$page05_colours_check1 == T) {
      fill = input$page05_colours_fill
      colour = input$page05_colours_colour
    } else {
      fill = '#00BFC4'
      colour = '#00BFC4'
    }
    
    # ggplot 初始圖
    ggRoot = ggplot(
      data(),
      aes_string(
        x = input$page05_continuous_x_select1
      )
    ) +
      # 標題, x軸標題, y軸標題
      labs(
        title = input$page05_ui_title_text1,
        x = input$page05_x_title_text1,
        y = input$page05_y_title_text1
      ) +
      # 直方圖
      geom_histogram(
        bins = input$page05_ui_bins_num1,
        fill = fill,
        colour = colour,
        size = .5
        )
    
    # 畫圖
    ggRoot + 
      theme(
        # 圖標題
        plot.title = element_text(
          size = input$page05_ui_title_num1,
          face = 'bold',
          hjust = 0.5
        ),
        # 軸標題
        axis.title = element_text(
          size = input$page05_ui_axis_title_num1,
          face = 'bold'
        ),
        # 軸標籤
        axis.text = element_text(
          size = input$page05_ui_axis_label_num1,
          face = 'bold'
        ),
        # x軸標籤(角度)
        axis.text.x = element_text(
          angle = input$page05_ui_axis_angle_slider1,
          vjust = 0.5
        )
      )
  },
  # 顯示圖的寬高
  width = input$page05_ui_download_width_num1,
  height = input$page05_ui_download_height_num1
  )
})
# 下載
output$downloadPlot_5 <- downloadHandler(
  filename = function() {
    # 下載後的名字
    paste(input$page05_ui_title_text1, '.png', sep = ' ')
  },
  content = function(file) {
    ggsave(
      file,
      dpi = 'screen',
      units = 'px',
      width = input$page05_ui_download_width_num1,
      height = input$page05_ui_download_height_num1
    )
  }
)

outputOptions(output, 'page05_ui_x_title_text1', suspendWhenHidden = FALSE)