<?php

class DrugsController extends GxController {


public function filters() {
	return array(
			'accessControl', 
			);
}

public function accessRules() {
	return array(
			
			array('allow', 
				'actions'=>array('index', 'view','admin','minicreate', 'create', 'update', 'cashBooster', 'delete','GeneratePdf','GenerateExcel','UpdateBooster'),
				'expression'=>'$user->groupe == 2 || $user->groupe == 4 || $user->groupe == 5 || $user->groupe == 6',
				),
			array('deny', 
				'users'=>array('*'),
				),
			);
}
    public function actionUpdateBooster()
	{
		    $es = new EditableSaver('Drugs');
			$es->update();
	}
	 public function actionCashBooster()
	{
         $connection = Yii::app()->db;
          $transaction=$connection->beginTransaction();
          
           try
            {
            
            $new_price = yii::app()->request->getParam('value');
		    $es = new EditableSaver('Drugs');
		       $sql = 'insert into price_history (iddrug, ancient_price, new_price, old_changedate, userid) values (1,'.$ancient_price.','.$new_price.',now(),'.Yii::app()->user->id.')';
               $connection->createCommand($sql)->execute();
               $es->update();
               $transaction->commit();
           }
           catch(Exception $e) // an exception is raised if a query fails
			{
			     $transaction->rollBack();
			}
			 
			


	}
	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'Drugs'),
		));
	}

	public function actionCreate() {
		$model = new Drugs;


		if (isset($_POST['Drugs'])) {
			$model->setAttributes($_POST['Drugs']);

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
		$model = $this->loadModel($id, 'Drugs');
          $connection = Yii::app()->db;
          $ok=null;
          $transaction=$connection->beginTransaction();
          try
            {
              if (isset($_POST['Drugs'])) {
						$model->setAttributes($_POST['Drugs']);
                        $new_price = $_POST['Drugs']['cash'];
					       $ancient_sql = "select cash from drugs where id= ".$id;
					       $ancient_price = $connection->createCommand($ancient_sql)->queryScalar();

					       $olddate_sql = "select count(*) num ,changedate from price_history where iddrug= ".$id." and last = 1";
					       
					       
					       $row = $connection->createCommand($olddate_sql)->queryRow();
					       
					       
					       if($row['num'] == 0){
					       	   $old_changedate = date('Y-m-d H:i:s');
					       	}else{

					       		$old_changedate = $row['changedate'];
					       		$LastUpdate = "update price_history set last = 0 where iddrug= ".$id;
					       		$connection->createCommand($LastUpdate)->execute();
					       	}
					       
					       $sql = 'insert into price_history (iddrug, ancient_price, new_price, old_changedate, userid,last) values ('.$id.','.$ancient_price.','.$new_price.',"'.$old_changedate.'",'.Yii::app()->user->id.',1)';
			               
			               
			               
			               $connection->createCommand($sql)->execute();

						if ($model->save()) {
							$transaction->commit();
							$this->redirect(array('index'));
						}
					}

               
           }
           catch(Exception $e) // an exception is raised if a query fails
			{
			     $transaction->rollBack();
			}

		
		$this->render('update', array(
				'model' => $model,
				));

	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Drugs')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Drugs');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Drugs('search');
		$model->unsetAttributes();

		if (isset($_GET['Drugs']))
			$model->setAttributes($_GET['Drugs']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

      public function actionGenerateExcel()
	{
            $session=new CHttpSession;
            $session->open();		
            
             if(isset($session['Drugs_records']))
               {
                $model=$session['Drugs_records'];
               }
               else
                 $model = Drugs::model()->findAll();

		
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

             if(isset($session['Drugs_records']))
               {
                $model=$session['Drugs_records'];
               }
               else
                 $model = Drugs::model()->findAll();



		$html = $this->renderPartial('expenseGridtoReport', array(
			'model'=>$model
		), true);
		
		//die($html);
		
		$pdf = new TCPDF();
		$pdf->SetCreator(PDF_CREATOR);
		$pdf->SetAuthor(Yii::app()->name);
		$pdf->SetTitle('Drugs Report');
		$pdf->SetSubject('Drugs Report');
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
		$pdf->Output("Drugs_002.pdf", "I");
	}
}
