#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Load data from Arctic Data Center
data_url <- "https://arcticdata.io/metacat/d1/mn/v2/object/urn%3Auuid%3A35ad7624-b159-4e29-a700-0c0770419941"
bg_chem <- read.csv(url(data_url, method = "libcurl"), stringsAsFactors = F)

names(bg_chem)

# Goal: 
# In this app, we will plot CTD depth against salinity

# Define UI for application that draws a histogram
# The 'fluidPage' sets the layout for the UI
ui <- fluidPage(

    # Application title
    titlePanel("Water Biogeochemistry"),

    # Sidebar with a slider input for number of bins 
    # Within the sidebar, we have a slider that the user will interact with. 
    sidebarLayout(
        sidebarPanel(
            sliderInput("depth",
                        "Depth (m):",
                        min = 1,
                        max = 500,
                        value = c(1, 100)) # This is the default
            ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
           plotOutput("secondPlot")
        )
    )
)

# Define server logic required to draw a histogram
# Input from the user, output from the server
server <- function(input, output) {

    output$distPlot <- renderPlot({
       ggplot(bg_chem, mapping = aes(x = CTD_Depth, y = CTD_Salinity))+
            geom_point(size = 4, color = "blue") +
            theme_light()+ 
            xlim(input$depth[1], input$depth[2]) +
            ylab("CTD Depth (m)") +
            xlab("Salinity (units)")
    })
    output$secondPlot <- renderPlot({
        ggplot(bg_chem, mapping = aes(x = CTD_Depth, y = CTD_Temperature))+
            geom_point(size = 4, color = "red") +
            theme_light()+ 
            xlim(input$depth[1], input$depth[2]) +
            ylab("CTD Depth (m)") +
            xlab("Temperature (units)")
    })
}

# Run the application 
# Tells shiny to use the UI we created and the server we created.
shinyApp(ui = ui, server = server)
