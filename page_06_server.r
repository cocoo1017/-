### page 06 - 圓餅圖

## 主要變數(連續)
output$page06_ui_continuous_select1 <- renderUI({
  # 選項
  choices_y_6 = colTypeData()$cont
  names(choices_y_6) = colTypeData()$label_cont
  # 下拉選單
  selectInput(
    'page06_continuous_select1',
    label = labelWithInfo('主要變數 (連續型)', 'page06_actionLink_continuous'),
    choices = choices_y_6
  )
})
## 說明視窗(主要變數)
observeEvent(input$page06_actionLink_continuous, {
  shinyalert(
    text = '請選擇欲呈現於圓餅圖之連續變數。'
  )
})
## 主要變數(x軸)標題
output$page06_ui_x_title_text1 <- renderUI({
  index_06_X = grep(input$page06_continuous_select1, colnames(data()))
  default_06_X = colTypeData()$label[index_06_X]
  textInput(
    'page06_x_title_text1',
    label = '主要變數標題',
    value = default_06_X
  )
})

## 分組變數(類別)
output$page06_ui_discrete_select1 <- renderUI({
  # 選項
  choices_x_6 = colTypeData()$cate
  names(choices_x_6) = colTypeData()$label_cate
  selectInput(
    'page06_discrete_x_select1',
    label = labelWithInfo('分組變數 (類別型)', 'page06_actionLink_discrete_x'),
    choices = choices_x_6
  )
})
## 說明視窗(分組變數)
observeEvent(input$page06_actionLink_discrete_x, {
  shinyalert(
    text = '請選擇作為主要變數分組依據之類別變數。'
  )
})

## 說明視窗(軸標題 + 右側圖示標題)
observeEvent(input$page06_actionLink_axis_title, {
  shinyalert(
    text = '變更主要變數(X軸)標題字體尺寸時，右側圖示標題將同時變動。'
  )
})

## 說明視窗(軸標籤 + 右側圖示標籤)
observeEvent(input$page06_actionLink_axis_label, {
  shinyalert(
    text = '變更軸標籤字體尺寸時，右側圖示標籤將同時變動。'
  )
})

## 顏色
output$page06_colours <- renderUI({
  req(input$page06_colours_check1)
  # 動態生成 分組變數之類別個數 個 colourInput
  # 先判斷是否有遺失值
  if (T %in% is.na(data()[,input$page06_discrete_x_select1])) {
    colour_num_06 = nrow(unique(data()[,input$page06_discrete_x_select1])) - 1
  } else {
    colour_num_06 = nrow(unique(data()[,input$page06_discrete_x_select1]))
  }
  colourInputList_06 <- list()
  for (i in 1:colour_num_06) {
    colourInputList_06[[i]] = colourInput(
      paste0('page6_colour_', i),
      label = paste0('第', i, '個變數'),
      palette = 'square',
      value = hue_pal()(i)[i]
    )
  }
  colourInputList_06
})

## 圓餅圖
observe({
  output$page06_piechart <- renderPlot({
    # 檢核
    req(input$page06_continuous_select1)
    req(input$page06_discrete_x_select1)
    
    # 顏色向量
    values_06 <- c()
    for (i in 1:nrow(unique(data()[,input$page06_discrete_x_select1]))) {
      values_06[[i]] <- input[[paste0('page6_colour_', as.character(i))]]
    }
    
    # 判斷是否自訂顏色
    if (input$page06_colours_check1 == T) {
      colour_06 = scale_fill_manual(values = unlist(values_06))
    } else {
      colour_06 = NULL
    }
    
    # 畫圖
    ggplot(data(), aes(x = ' ', y = !!sym(input$page06_continuous_select1), fill = !!sym(input$page06_discrete_x_select1))) +  # y = 連續, fill = 類別
      geom_bar(stat = 'identity') +
      coord_polar('y', start = 0) +
      # 標題, x軸標題, y軸標題
      labs(
        title = input$page06_ui_title_text1,
        x = '',
        y = input$page06_x_title_text1
      ) +
      theme(
        # 圖標題
        plot.title = element_text(
          size = input$page06_ui_title_num1,
          face = 'bold',
          hjust = 0.5
        ),
        # 軸標題
        axis.title = element_text(
          size = input$page06_ui_axis_title_num1,
          face = 'bold'
        ),
        # 軸標籤
        axis.text = element_text(
          size = input$page06_ui_axis_label_num1,
          face = 'bold'
        ),
        # 右側圖示標題
        legend.title = element_text(size = input$page06_ui_axis_title_num1),
        # 右側圖示標籤
        legend.text = element_text(size = input$page06_ui_axis_label_num1)
      ) + colour_06
  },
  # 顯示圖的寬高
  width = input$page06_ui_download_width_num1,
  height = input$page06_ui_download_height_num1
  )
})
# 下載
output$downloadPlot_6 <- downloadHandler(
  filename = function() {
    # 下載後的名字
    paste(input$page06_ui_title_text1, '.png', sep = ' ')
  },
  content = function(file) {
    ggsave(
      file,
      dpi = 'screen',
      units = 'px',
      width = input$page06_ui_download_width_num1,
      height = input$page06_ui_download_height_num1
    )
  }
)

outputOptions(output, 'page06_ui_x_title_text1', suspendWhenHidden = FALSE)