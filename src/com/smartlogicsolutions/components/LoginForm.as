package com.smartlogicsolutions.components {
	
	import com.smartlogicsolutions.events.LoginEvent;
	
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.primitives.supportClasses.TextGraphicElement;
	
	/**
	 * Dispatched when the login button is pressed.
	 *
	 * @eventType com.smartlogicsolutions.events.LoginEvent.LOGIN
	 */
	[Event(name="login", type="com.smartlogicsolutions.events.LoginEvent")]
	
	/**
	 * Normal state of the form.
	 */
	[SkinState("login")]
	
	/**
	 * State of the form when attempting to log in.
	 */
	[SkinState("loggingIn")]
	
	/**
	 * State of the form after successfully logged in.
	 */
	[SkinState("loggedIn")]
	
	/**
	 * The LoginForm class provides labels, input text fields, a login button,
	 * and messaging for a login form.
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @author Greg Jastrab <greg@smartlogicsolutions.com>
	 * @version 0.1
	 */
	public class LoginForm extends SkinnableComponent {
		
		/* --- Variables --- */
		
			/* --vv-- Skin Parts --vv-- */
			
		[SkinPart]
		public var loginButton:Button;
		
		[SkinPart]
		public var loginField:TextInput;
		
		[SkinPart]
		public var passwordField:TextInput;
		
		[SkinPart(required="false")]
		public var loginFieldLabel:TextGraphicElement;
		
		private var _loginLabel:String = "Login";
		
		[SkinPart(required="false")]
		public var passwordFieldLabel:TextGraphicElement;
		
		private var _passwordLabel:String = "Password";
		
		[SkinPart(required="false")]
		public var loginMessage:TextGraphicElement;
	
		private var _loginMessageLabel:String = "";
		
			/* ==^^== Skin Parts ==^^== */
		
		[Bindable]
		/**
		 * Label to describe the progress of the login action.
		 *
		 * @default ""
		 */
		public var loginMessageLabel:String = "";
		
		protected var loggingIn:Boolean = false;
		
		protected var loggedIn:Boolean = false;
		
		private var _loggingInMessage:String = "Logging in...";
		
		private var _loggedInMessage:String = "Login Successful!";
		
		/* === Variables === */
		
		/* --- Functions --- */
		
		/**
		 * To be called if the login action has failed.
		 */
		public function loginFailed():void {
			loggingIn = loggedIn = false;
			invalidateSkinState();
		}
		
		/**
		 * To be called if the login action has succeeded.
		 */
		public function loginSucceeded():void {
			loggingIn = false;
			loggedIn = true;
			invalidateSkinState();
		}
		
		override protected function commitProperties():void {
			var pendingSkinState:String = getCurrentSkinState();

			// swap login message if necessary			
			if(currentState != pendingSkinState) {
				if(pendingSkinState == "loggingIn")
					loginMessageLabel = loggingInMessage;
				else if(pendingSkinState == "loggedIn")
					loginMessageLabel = loggedInMessage;
			}
			else {
				// check if loggingInMessage changed while in loggingIn state
				if(currentState == "loggingIn" && loginMessageLabel != loggingInMessage)
					loginMessageLabel = loggingInMessage;
				else if(currentState == "loggedIn" && loginMessageLabel != loggedInMessage)
					loginMessageLabel = loggedInMessage;
			}
			
			super.commitProperties();
		}
		
		override protected function getCurrentSkinState():String {
			if(loggingIn)
				return "loggingIn";
			
			if(loggedIn)
				return "loggedIn";
			
			return "login";
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if(instance === loginButton) {
				loginButton.addEventListener(MouseEvent.CLICK, loginButton_clickHandler);
			}
			else if(instance === loginField) {
				// TODO add validation checking focus handlers
			}
			else if(instance === passwordField) {
				passwordField.displayAsPassword = true;
				// TODO add validation checking focus handlers
			}
			else if(instance === loginFieldLabel) {
				loginFieldLabel.text = loginLabel;
			}
			else if(instance === passwordFieldLabel) {
				passwordFieldLabel.text = passwordLabel;
			}
			
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			if(instance === loginButton) {
				loginButton.removeEventListener(MouseEvent.CLICK, loginButton_clickHandler);
			}
		}
		
		/* === Functions === */
		
		/* --- Event Handlers --- */
		
		/**
		 * Event handler for when the login button is clicked.
		 *
		 * @param evt associated event object
		 */
		protected function loginButton_clickHandler(evt:MouseEvent):void {
			if(!loggingIn && !loggedIn) {
				loggingIn = true;
				invalidateSkinState();
				
				// TODO: add validation
				dispatchEvent( new LoginEvent(LoginEvent.LOGIN, loginField.text, passwordField.text) );
			}
		}
		
		/* === Event Handlers === */
		
		/* --- Public Accessors --- */
		
		[Bindable]
		/**
		 * Message to display when logging in.
		 *
		 * @default "Logging in..."
		 */
		public function get loggingInMessage():String { return _loggingInMessage; }
		
		/** @private */
		public function set loggingInMessage(value:String):void {
			if(_loggingInMessage != value) {
				_loggingInMessage = value;
				invalidateProperties();
			}
		}
		
		[Bindable]
		/**
		 * Message to display when login succeeded.
		 *
		 * @default "Login Successful!"
		 */
		public function get loggedInMessage():String { return _loggedInMessage; }
		
		/** @private */
		public function set loggedInMessage(value:String):void {
			if(_loggedInMessage != value) {
				_loggedInMessage = value;
				invalidateProperties();
			}
		}
		
		[Bindable]
		/**
		 * Label to describe the login input field.
		 *
		 * @default "Login"
		 */
		public function get loginLabel():String { return _loginLabel; }
		
		/** @private */
		public function set loginLabel(value:String):void {
			_loginLabel = value;
			
			if(loginFieldLabel)
				loginFieldLabel.text = value;
		}
		
		[Bindable]
		/**
		 * Label to describe the password input field.
		 *
		 * @default "Password"
		 */
		public function get passwordLabel():String { return _passwordLabel; }
		
		/** @private */
		public function set passwordLabel(value:String):void {
			_passwordLabel = value;
			
			if(passwordFieldLabel)
				passwordFieldLabel.text = value;
		}
		
		/* === Public Accessors === */
		
	}
	
}