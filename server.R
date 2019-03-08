# Define server logic to summarize and view selected variable ----
server <- function(input, output) {
    
    
    # Return the requested dataset ----
    # By declaring datasetInput as a reactive expression we ensure that:
    # 1. It is only called when the inputs it depends on changes
    # 2. The computation and result are shared by all the callers,
    #    i.e. it only executes a single time    
    datasetInput <- reactive({
        switch(input$variable,
               "Ozone" = airquality$Ozone,
               "Solar.R" = airquality$Solar.R,
               "Wind" = airquality$Wind,
               "Temp" = airquality$Temp
        )
    })
    
    # Generate a boxplot of the selected variable by month ----
    # The output$plot1 depends on the datasetInput reactive
    # expression, so will be re-executed whenever datasetInput is
    # invalidated, i.e. whenever the input$variable changes
    output$plot1 <- renderPlotly({
        variable <- datasetInput()
        airquality$Month <- as.factor(airquality$Month)
        levels(airquality$Month) <- c("May", "Jun", "Jul", "Aug", "Sep")
        # Set a unique color with fill, colour, and alpha for boxplot
        p <- ggplot(airquality, aes(x=Month, y=variable)) + 
            geom_boxplot(color="black", fill="orange3", alpha=0.7) +
            labs(y = "")
        #boxplot(variable~Month, data = airquality)
        ggplotly(p)
            
    })
    
    # Show the first "n" rows ----
    # The output$view depends on the databaseInput reactive
    # input$rows, so it will be re-executed whenever
    # input$rows is changed
    output$view <- renderDT({
        head(airquality, n = input$rows)
        }, options = list(lengthChange = FALSE, paging = FALSE, searching = FALSE, dom = 'ft'))
    
}
