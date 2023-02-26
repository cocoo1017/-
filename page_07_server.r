### page 07 - 箱型圖

## x軸(分組)變數
output$page07_ui_discrete_x_select1 <- renderUI({
  # 選項
  choices_x_7 = colTypeData()$cate
  names(choices_x_7) = colTypeData()$label_cate
  selectInput(
    'page07_discrete_x_select1',
    label = labelWithInfo('x 軸變數 (類別型)', 'page07_actionLink_discrete_x'),
    choices = c('NULL', choices_x_7)
  )
})
## 說明視窗(x軸)
observeEvent(input$page07_actionLink_discrete_x, {
  shinyalert(
    text = '請選擇欲呈現於X軸之類別變數。
    (將以此變數之類別作為分組依據。)
    (NULL:不選擇任何變數，將呈現單一變數之箱形圖。)'
  )
})
## x軸標題
output$page07_ui_x_title_text1 <- renderUI({
  index_07_X = grep(input$page07_discrete_x_select1, colnames(data()))
  default_07_X = colTypeData()$label[index_07_X]
  textInput(
    'page07_x_title_text1',
    label = 'X軸標題',
    value = default_07_X
  )
})

## Y軸變數
output$page07_ui_continuous_select1 <- renderUI({
  # 選項
  choices_y_7 = colTypeData()$cont
  names(choices_y_7) = colTypeData()$label_cont
  # 下拉選單
  selectInput(
    'page07_continuous_select1',
    label = labelWithInfo('Y 軸變數 (連續型)', 'page07_actionLink_continuous'),
    choices = choices_y_7
  )
})
## 說明視窗(Y軸)
observeEvent(input$page07_actionLink_continuous, {
  shinyalert(
    text = '請選擇欲呈現於Y軸之連續變數。'
  )
})
## Y軸標題
output$page07_ui_y_title_text1 <- renderUI({
  index_07_y = grep(input$page07_continuous_select1, colnames(data()))
  default_07_y = colTypeData()$label[index_07_y]
  textInput(
    'page07_y_title_text1',
    label = 'Y軸標題',
    value = default_07_y
  )
})

## 說明視窗(軸標題 + 右側圖示標題)
observeEvent(input$page07_actionLink_axis_title, {
  shinyalert(
    text = '變更軸標題字體尺寸時，右側圖示標題將同時變動。'
  )
})

## 說明視窗(軸標籤 + 右側圖示標籤)
observeEvent(input$page07_actionLink_axis_label, {
  shinyalert(
    text = '變更軸標籤字體尺寸時，右側圖示標籤將同時變動。'
  )
})

## 顏色
output$page07_colours <- renderUI({
  req(input$page07_colours_check1)
  # 當x軸變數 = NULL 時, 只輸出一個 colourInput
  if (input$page07_discrete_x_select1 == 'NULL') {
    colourInput(
      'page07_null_colour1',
      label = '',
      palette = 'square',
      value = '#00BFC4'
    )
  } else {
    # 當x軸變數 != NULL 時, 動態生成 x軸變數之類別個數 個 colourInput
    # 先判斷是否有遺失值
    if (T %in% is.na(data()[,input$page07_discrete_x_select1])) {
      colour_num_07 = nrow(unique(data()[,input$page07_discrete_x_select1])) - 1
    } else {
      colour_num_07 = nrow(unique(data()[,input$page07_discrete_x_select1]))
    }
    colourInputList_07 <- list()
    for (i in 1:colour_num_07) {
      colourInputList_07[[i]] = colourInput(
        paste0('page7_colour_', i),
        label = paste0('第', i, '個變數'),
        palette = 'square',
        value = hue_pal()(i)[i]
      )
    }
    colourInputList_07
  }
})

## 離群值顏色
output$page07_outlier_colour <- renderUI({
  req(input$page07_outlier_check1)
  colourInput(
    'page07_outlier_colour1',
    label = '',
    palette = 'square',
    value = '#627B91'
  )
})

## 箱型圖
observe({
  output$page07_boxplot <- renderPlot({
    # 檢核
    req(input$page07_discrete_x_select1)
    req(input$page07_continuous_select1)
    
    # 顏色向量(x軸變數 != NULL時)
    if (input$page07_discrete_x_select1 != 'NULL') {
      values_07 <- c()
      for (i in 1:nrow(unique(data()[,input$page07_discrete_x_select1]))) {
        values_07[[i]] <- input[[paste0('page7_colour_', as.character(i))]]
      }
    }

    # 判斷是否自訂顏色(x軸變數 != NULL)
    if (input$page07_discrete_x_select1 != 'NULL' & input$page07_colours_check1 == T) {
      colour_07 = scale_fill_manual(values = unlist(values_07))
    } else {
      colour_07 = NULL
    }
    # 判斷是否自訂顏色(群組變數 == NULL)
    if (input$page07_discrete_x_select1 == 'NULL' & input$page07_colours_check1 == T) {
      fill = input$page07_null_colour1
    } else {
      fill = '#00BFC4'
    }
    
    # 判斷是否自訂離群值外觀
    if (input$page07_outlier_check1 == T) {
      colour_outlier_07 = input$page07_outlier_colour1
      num1_outlier_07 = input$page07_ui_outlier_num1
    } else {
      colour_outlier_07 = '#627B91'
      num1_outlier_07 = 1
    }
    
    # ggplot 初始圖
    ggRoot = ggplot(
      data(),
      aes_string(
        y = input$page07_continuous_select1
      )
    ) +
      # 標題, x軸標題, y軸標題
      labs(
        title = input$page07_ui_title_text1,
        x = input$page07_x_title_text1,
        y = input$page07_y_title_text1
      )
    
    # 是否要分組
    if(input$page07_discrete_x_select1 == 'NULL'){
      ggbox = geom_boxplot(
        fill = fill,
        outlier.colour = colour_outlier_07, # 離群值標示顏色
        outlier.shape = 19, # 離群值標示樣式
        outlier.size = num1_outlier_07
      )
    } else {
      ggbox = geom_boxplot(
        aes_string(
          x = input$page07_discrete_x_select1,
          fill = input$page07_discrete_x_select1
        ),
        outlier.colour = colour_outlier_07, # 離群值標示顏色
        outlier.shape = 19, # 離群值標示樣式
        outlier.size = num1_outlier_07 # 離群值標示尺寸
      )
    }
    
    # 畫圖
    ggRoot + ggbox + 
      theme(
        # 圖標題
        plot.title = element_text(
          size = input$page07_ui_title_num1,
          face = 'bold',
          hjust = 0.5
        ),
        # 軸標題
        axis.title = element_text(
          size = input$page07_ui_axis_title_num1,
          face = 'bold'
        ),
        # 軸標籤
        axis.text = element_text(
          size = input$page07_ui_axis_label_num1,
          face = 'bold'
        ),
        # x軸標籤(角度)
        axis.text.x = element_text(
          angle = input$page07_ui_axis_angle_slider1,
          vjust = 0.5
        ),
        # 右側圖示標題
        legend.title = element_text(size = input$page07_ui_axis_title_num1),
        # 右側圖示標籤
        legend.text = element_text(size = input$page07_ui_axis_label_num1)
      ) +
      scale_x_discrete() + 
      colour_07
  },
  # 顯示圖的寬高
  width = input$page07_ui_download_width_num1,
  height = input$page07_ui_download_height_num1
  )
})
# 下載
output$downloadPlot_7 <- downloadHandler(
  filename = function() {
    # 下載後的名字
    paste(input$page07_ui_title_text1, '.png', sep = ' ')
  },
  content = function(file) {
    ggsave(
      file,
      dpi = 'screen',
      units = 'px',
      width = input$page07_ui_download_width_num1,
      height = input$page07_ui_download_height_num1
    )
  }
)

outputOptions(output, 'page07_ui_x_title_text1', suspendWhenHidden = FALSE)
outputOptions(output, 'page07_ui_y_title_text1', suspendWhenHidden = FALSE)