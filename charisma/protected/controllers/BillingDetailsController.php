<?php

class BillingDetailsController extends GxController {
public function filters() {
	return array(
			'accessControl', 
			);
}

public function accessRules() {
		return array(
		
			array('allow', 
				'actions'=>array('index', 'view','admin','minicreate', 'create', 'update',  'delete','UpdateBooster'),
				'expression'=>'$user->groupe == 1 || $user->groupe == 2 ||  $user->groupe == 4 || $user->groupe == 5 || $user->groupe == 3 ',
				),
			array('deny', 
				'users'=>array('*'),
				),
			);
}
public function actionUpdateBooster()
	{
		    $es = new EditableSaver('BillingDetails');
			$es->update();
	}
	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'BillingDetails'),
		));
	}

	public function actionCreate() {
		$model = new BillingDetails;

        //CVarDumper::dump($_POST,20,true);
		if(isset($_POST['idinvoice']))
		{	
			$total = count($_POST['idinvoice']);
			for ($i = 0; $i <= $total; $i++)
		    {
		    	if(isset($_POST['idinvoice'][$i]))
		    	{
				    	
				    $model1 = new BillingDetails();	
		            $model1->idinvoice=$_POST['idinvoice'][$i];
		            $model1->idmedical=$_POST['idmedical'][$i];
		            $model1->price=$_POST['price'][$i];
		            $model1->quantity=$_POST['quantity'][$i];
		            $model1->save();
		             //$this->render('create',array('model'=>$model, 'dumpModel'=>true));

		       }
		    }
		   
		}
		 $this->render('create',array('model'=>$model, 'dumpModel'=>false));
		
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'BillingDetails');


		if (isset($_POST['BillingDetails'])) {
			$model->setAttributes($_POST['BillingDetails']);

			if ($model->save()) {
				$this->redirect(array('billingDetails/create', 'idinvoice' => $model->idinvoice,'type'=>$_REQUEST['type']));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'BillingDetails')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('BillingDetails');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new BillingDetails('search');
		$model->unsetAttributes();

		if (isset($_GET['BillingDetails']))
			$model->setAttributes($_GET['BillingDetails']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

}