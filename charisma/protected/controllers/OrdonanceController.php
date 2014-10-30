<?php

class OrdonanceController extends GxController {

public function filters() {
	return array(
			'accessControl', 
			);
}

public function accessRules() {
	return array(
		
			array('allow', 
				'actions'=>array('index', 'view','minicreate', 'create', 'update', 'admin', 'delete','UpdateBooster'),
				'expression'=>'$user->groupe == 4 || $user->groupe == 5 || $user->groupe == 1 || $user->groupe == 3 ',
				),
			array('deny', 
				'users'=>array('*'),
				),
			);
}


public function actionUpdateBooster()
	{
		    $es = new EditableSaver('Ordonance');
			$es->update();
	}
	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'Ordonance'),
		));
	}

	public function actionCreate() {
		$model = new Ordonance;


		if (isset($_POST['Ordonance'])) {
			$model->setAttributes($_POST['Ordonance']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				//else
					//$this->redirect(array('create', 'idinvoice' => $_POST['idinvoice']));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Ordonance');


		if (isset($_POST['Ordonance'])) {
			$model->setAttributes($_POST['Ordonance']);

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
			$this->loadModel($id, 'Ordonance')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Ordonance');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Ordonance('search');
		$model->unsetAttributes();

		if (isset($_GET['Ordonance']))
			$model->setAttributes($_GET['Ordonance']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

}