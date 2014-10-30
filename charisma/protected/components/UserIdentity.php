<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CUserIdentity
{
    private $_id;
	public $status;
	public $_username;
        /**
         * Authenticates a user.
         * The example implementation makes sure if the username and password
         * are both 'demo'.
         * In practical applications, this should be changed to authenticate
         * against some persistent user identity storage (e.g. database).
         * @return boolean whether authentication succeeds.
         */
        public function authenticate()
        {
                
            $users= Users::model()->findByAttributes(array('username'=>$this->username,'status'=>1));
            
            if($users===null) {
                $this->errorCode = self::ERROR_USERNAME_INVALID;                
            }
            else if(!$users->validatePassword($this->password)) {
                $this->errorCode = self::ERROR_PASSWORD_INVALID;
            }
            else {           
                $this->errorCode = self::ERROR_NONE;
                $this->_id = $users->id;
				$this->setState('status', $users->status);
				Yii::app()->session->add('username',$this->username); ;//$users->username;
				Yii::app()->session['iduser'] = $users->id;
                Yii::app()->session['group'] = $users->groupe;
            }
            return !$this->errorCode;
        }
		        
        public function getId() {
            return $this->_id;
        }

          public function getUsername() {
            return $this->_username;
        }

}