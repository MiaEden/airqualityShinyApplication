# Coursera Developing Data Products Assignment - shiny application

# Loading libraries
library(shiny); library(plotly); library(ggplot2); library(shinyWidgets); library(DT)

# Define UI for dataset viewer app ----
ui <- fluidPage(
    
    #setBackgroundColor("Wheat"),
    setBackgroundColor(
    color = c("#fbfbfb", "#FFDB99"),
    gradient = "radial",
    direction = c("top", "left")
    ),

    # App title ----
    titlePanel("1973 New York Air Quality Measurements"),
    
    tags$br(),
    
    h5("This is a reactive application for the R dataset airquality, showing plotly boxplot by month for each variable."),

    tags$br(),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Numeric entry for number of rows to view ----
            sliderInput(inputId = "rows",
                         label = "Action 1- Choose the number of rows for previewing the table or keep default 5 rows:",
                         value = 5,
                         min = 1,
                         max = 10),

            h5(">>>>  Reactive results for your selection above are seeing on the right (table).  >>>>"),
            
            tags$br(),
            # Input: Selector for choosing variable ----
            selectInput(inputId = "variable",
                        label = "Action 2- Choose a variable from airquality dataset to see its boxplot by month.",
                        choices = names(airquality)[1:4]),
            h5(">>>>  Reactive results for your selection above are seeing on the right (chart). >>>>")
            
        ),
        

        # Main panel for displaying outputs ----
        mainPanel(
            
            # table title
            h5("Reaction 1 - Airquality dataset preview (all variables), for the number of rows you selected:"),
            
            # Output: HTML table with requested number of rows ----
            DTOutput("view"),
            
            # Chart title:
            h5("Reaction 2- Plotly Boxplot for the airquality variable you selected, by month:"),
            # Output: boxplot
            plotlyOutput("plot1")
            

            
        )
    )
)

