// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application"

import ItemsController from "./items_controller"
application.register("items", ItemsController)
