<?php

class InvoiceController extends GxController {

public function filters() {
	return array(
			'accessControl', 
			);
}

public function accessRules() {
	return array(
		array('allow', 
				'actions'=>array(  'delete'),
				'expression'=>'$user->groupe == 4 || $user->groupe == 5',
				),
			array('allow', 
				'actions'=>array('index', 'view','admin','minicreate', 'create', 'update','GeneratePdf','GenerateExcel','UpdateBooster'),
				'expression'=>'$user->groupe == 1 || $user->groupe == 2 || $user->groupe == 3 || $user->groupe == 4 || $user->groupe == 5 || $user->groupe == 6',
				),
			array('deny', 
				'users'=>array('*'),
				),
			);
}public function actionUpdateBooster()
	{
		    $es = new EditableSaver('Invoice');
			$es->update();
	}
	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'Invoice'),
		));
	}

	public function actionCreate() {
		$model = new Invoice;


		if (isset($_POST['Invoice'])) {
			$model->setAttributes($_POST['Invoice']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest()){
					Yii::app()->end();
				}
				else{
					if($model->type == 4){
					$this->redirect(array('billingDrug/create', 'idinvoice' => $model->id,'type'=>$model->type));
				   }
                    if($model->type == 3){
                    	$this->redirect(array('ordonance/create', 'idinvoice' => $model->id,'type'=>$model->type));
				   }
				   else{

                    $this->redirect(array('billingDetails/create', 'idinvoice' => $model->id,'type'=>$model->type));
				}
				}
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Invoice');


		if (isset($_POST['Invoice'])) {
			$model->setAttributes($_POST['Invoice']);

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
			$this->loadModel($id, 'Invoice')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Invoice');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Invoice('search');
		$model->unsetAttributes();

		if (isset($_GET['Invoice']))
			$model->setAttributes($_GET['Invoice']);

		$this->render('admin', array(
			'model' => $model,
		));
	}
 public function actionGenerateExcel()
	{
            $session=new CHttpSession;
            $session->open();		
            
             if(isset($session['Invoice_records']))
               {
                $model=$session['Invoice_records'];
               }
               else
                 $model = Invoice::model()->findAll();

		
		Yii::app()->request->sendFile(date('YmdHis').'.xls',
			$this->renderPartial('excelReport', array(
				'model'=>$model
			), true)
		);
	}
        public function actionGeneratePdf() 
	{
           $session=new CHttpSession;
           $session->open();
		Yii::import('application.modules.admin.extensions.giiplus.bootstrap.*');
		require_once('tcpdf/tcpdf.php');
		require_once('tcpdf/config/lang/eng.php');

             if(isset($session['Invoice_records']))
               {
                $model=$session['Invoice_records'];
               }
               else
                 $model = Invoice::model()->findAll();



		$html = $this->renderPartial('expenseGridtoReport', array(
			'model'=>$model
		), true);
		
		//die($html);
		
		$pdf = new TCPDF();
		$pdf->SetCreator(PDF_CREATOR);
		$pdf->SetAuthor(Yii::app()->name);
		$pdf->SetTitle('Invoice Report');
		$pdf->SetSubject('Invoice Report');
		//$pdf->SetKeywords('example, text, report');
		$pdf->SetHeaderData('', 0, "Report", '');
		$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, "Example Report by ".Yii::app()->name, "");
		$pdf->setHeaderFont(Array('helvetica', '', 8));
		$pdf->setFooterFont(Array('helvetica', '', 6));
		$pdf->SetMargins(15, 18, 15);
		$pdf->SetHeaderMargin(5);
		$pdf->SetFooterMargin(10);
		$pdf->SetAutoPageBreak(TRUE, 0);
		$pdf->SetFont('dejavusans', '', 7);
		$pdf->AddPage();
		$pdf->writeHTML($html, true, false, true, false, '');
		$pdf->LastPage();
		$pdf->Output("Invoice_002.pdf", "I");
	}
}
