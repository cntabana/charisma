<?php

class UsersController extends GxController {

public function filters() {
	return array(
			'accessControl', 
			);
}

public function accessRules() {
	return array(
			array('allow', 
				'actions'=>array('Changepassword','changePasswordUser', 'UpdateBooster','UpdatePaswword'),
				'users'=>array('*'),
				),
			array('allow', 
				'actions'=>array('Changepassword','index', 'view','minicreate', 'create', 'update', 'admin', 'delete','UpdateBooster','UpdatePaswword'),
				'expression'=>'$user->groupe == 4 || $user->groupe == 5',
				),
			array('deny', 
				'users'=>array('*'),
				),
			);
}

public function actionUpdateBooster()
	{
		    $es = new EditableSaver('Users');
			$es->update();
	}
	public function actionUpdatePaswword()
    {
		    $es = new EditableSaver('Users');
			$es->update();
	}
	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'Users'),
		));
	}

	public function actionCreate() {
		$model = new Users;


		if (isset($_POST['Users'])) {
			$model->setAttributes($_POST['Users']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Users');


		if (isset($_POST['Users'])) {
			$model->setAttributes($_POST['Users']);

			if ($model->save()) {
				$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Users')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Users');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Users('search');
		$model->unsetAttributes();

		if (isset($_GET['Users']))
			$model->setAttributes($_GET['Users']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

	public function actionChangepassword($id)
 {      
    $model2 = new Users;
 
    $model = Users::model()->findByAttributes(array('id'=>$id));
    $model->setScenario('changePwd');
 
 
     if(isset($_POST['Users'])){
 
        $model->attributes = $_POST['Users'];
        $valid = $model->validate();
 
        if($valid){
 
          $model->password = $model->new_password;
          //$model->setAttributes($model->password);

          if($model->save())
             $this->redirect(array('users/changePasswordUser&p=profile'));
          else
             $this->redirect(array('changepassword','msg'=>'password not changed'));
            }
        }
 
    $this->render('changepassword',array('model'=>$model)); 
 }

 
 public function actionChangePasswordUser() {
		$dataProvider = new CActiveDataProvider('Users');
		$this->render('changePasswordUser', array(
			'dataProvider' => $dataProvider,
		));
	}


}