// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import FormController from "./form_controller"
application.register("form", FormController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import TomselectController from "./tomselect_controller"
application.register("tomselect", TomselectController)