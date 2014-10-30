<?php

class BillingDrugController extends GxController {

public function filters() {
	return array(
			'accessControl', 
			);
}

public function accessRules() {
	return array(
		
			array('allow', 
				'actions'=>array('index', 'view','minicreate', 'create', 'update', 'admin', 'delete','UpdateBooster'),
				'expression'=>'$user->groupe == 4 || $user->groupe == 5 || $user->groupe == 2 || $user->groupe == 3 ',
				),
			array('deny', 
				'users'=>array('*'),
				),
			);
}

public function actionUpdateBooster()
	{
		    $es = new EditableSaver('BillingDrug');
			$es->update();
	}
	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'BillingDrug'),
		));
	}
/*
	public function actionCreate() {
		$model = new BillingDrug;


		if (isset($_POST['BillingDrug'])) {
			$model->setAttributes($_POST['BillingDrug']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('billingDrug/create', 'idinvoice' => $model->idinvoice,'type'=>$_REQUEST['type']));
			}
		}

		$this->render('create', array( 'model' => $model));
	}
*/

	public function actionCreate() {
		$model = new BillingDrug;

        //CVarDumper::dump($_POST,20,true);
		if(isset($_POST['idinvoice']))
		{	
			$total = count($_POST['idinvoice']);
			for ($i = 0; $i <= $total; $i++)
		    {
		    	if(isset($_POST['idinvoice'][$i]))
		    	{
				    	
				    $model1 = new BillingDrug();	
		            $model1->idinvoice=$_POST['idinvoice'][$i];
		            $model1->iddrug=$_POST['iddrug'][$i];
		            $model1->quantity=$_POST['quantity'][$i];
		            $model1->save();
		             //$this->render('create',array('model'=>$model, 'dumpModel'=>true));

		       }
		    }
		   
		}
		 $this->render('create',array('model'=>$model, 'dumpModel'=>false));
		
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'BillingDrug');


		if (isset($_POST['BillingDrug'])) {
			$model->setAttributes($_POST['BillingDrug']);

			if ($model->save()) {
				$this->redirect(array('billingDrug/create', 'idinvoice' => $model->idinvoice,'type'=>$_REQUEST['type']));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'BillingDrug')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('BillingDrug');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new BillingDrug('search');
		$model->unsetAttributes();

		if (isset($_GET['BillingDrug']))
			$model->setAttributes($_GET['BillingDrug']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

}