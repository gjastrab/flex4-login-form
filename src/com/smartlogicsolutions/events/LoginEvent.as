package com.smartlogicsolutions.events {
	
	import flash.events.Event;
	
	/**
	 * Event class for login related events.
	 *
	 * @langversion 3.0
	 * @author Greg Jastrab <greg@smartlogicsolutions.com>
	 * @version 0.1
	 */
	public class LoginEvent extends Event {
		
		/* --- Variables --- */
		
		public static const LOGIN:String = "login";
		
		/**
		 * Login / username
		 */
		public var login:String;
		
		/**
		 * Password
		 */
		public var password:String;

		/* === Variables === */
		
		/* --- Constructor --- */
		
		/**
		 * Constructor.
		 */
		public function LoginEvent(type:String, login:String="", password:String="", bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type);
			
			this.login = login;
			this.password = password;
		}
		
		/* === Constructor === */
		
		/* --- Functions --- */
		
		/** @inheritDoc */
		override public function clone():Event {
			return new LoginEvent(type, login, password, bubbles, cancelable);
		}
		
		/** @inheritDoc */
		override public function toString():String {
			return formatToString("LoginEvent", "type", "login", "password", "bubbles", "cancelable");
		}
		
		/* === Functions === */
		
	}
	
}