var App = App || {};

App.main_modules = _.extend(App.main_modules, {
		// Backbone Model + Collection
		'model/todo': 'modules/todo_model',
		'collection/todos': 'modules/todo_collection',

		// Widgets
		'widget/todo_list_widget': 'modules/todo_list_widget',
		'widget/todo_widget': 'modules/todo_widget',
		'widget/todo_add_widget': 'modules/todo_add_widget',

		// Controllers
		'controller/TodoPage': 'modules/todo_page_controller'
});