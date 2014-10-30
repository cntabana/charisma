<?php

class BeneficaireController extends GxController {

public function filters() {
	return array(
			'accessControl', 
			);
}

public function accessRules() {
	return array(
			array('allow', 
				'actions'=>array('view','admin','lunette','formulaire','ordonnanceMedicale','analyseDemande','GeneratePdf','GenerateExcel'),
				'expression'=>'$user->groupe == 1 || $user->groupe == 2 || $user->groupe == 5 || $user->groupe == 4',
				),
			array('allow', 
				'actions'=>array('view','admin','index','minicreate', 'create', 'update',  'delete','UpdateBooster','lunette','formulaire','ordonnanceMedicale','analyseDemande','GeneratePdf','GenerateExcel'),
				'expression'=>'$user->groupe == 4 || $user->groupe == 5',
				),
			array('deny', 
				'users'=>array('*'),
				),
			);
}
	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'Beneficaire'),
		));
	}

	public function actionCreate() {
		$model = new Beneficaire;


		if (isset($_POST['Beneficaire'])) {
			/* ------------------------- Image code --------------------------------------- */

           $rnd = rand(0,9999);  // generate random number between 0-9999
           $model->setAttributes($_POST['Beneficaire']); //is always in action create
 
            $uploadedFile=CUploadedFile::getInstance($model,'photo');
            $fileName = "{$rnd}-{$uploadedFile}";  // random number + file name
            $model->photo = $fileName;

          /* ------------------------- End Image code --------------------------------------- */

			if ($model->save()) {
				$uploadedFile->saveAs(Yii::app()->basePath.'/../pictures/'.$fileName);  // image  
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Beneficaire');


		if (isset($_POST['Beneficaire'])) {
			$_POST['Beneficaire']['photo'] = $model->photo;

			$model->setAttributes($_POST['Beneficaire']);
            $uploadedFile=CUploadedFile::getInstance($model,'photo');
			if ($model->save()) {
				
				 if(!empty($uploadedFile))  // check if uploaded file is set or not
                  {
                       $uploadedFile->saveAs(Yii::app()->basePath.'/../pictures/'.$model->photo);
                  }
				$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Beneficaire')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Beneficaire');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Beneficaire('search');
		$model->unsetAttributes();

		if (isset($_GET['Beneficaire']))
			$model->setAttributes($_GET['Beneficaire']);

		$this->render('admin', array(
			'model' => $model,
		));
	}
public function actionUpdateBooster()
	{
		    $es = new EditableSaver('Beneficaire');
			$es->update();
	}
public function actionFormulaire($id) {

	$criteria=new CDbCriteria(array('condition'=>'id='.$id));

    $dataProvider = new CActiveDataProvider('Beneficaire', array(
            'criteria'=>$criteria,
    ));
		$this->render('formulaire', array(
			'dataProvider' => $dataProvider,
		));

		
	}

public function actionOrdonnanceMedicale($id) {

	$criteria=new CDbCriteria(array('condition'=>'id='.$id));

    $dataProvider = new CActiveDataProvider('Beneficaire', array(
            'criteria'=>$criteria,
    ));
		$this->render('ordonnanceMedicale', array(
			'dataProvider' => $dataProvider,
		));

		
	}

	public function actionAnalyseDemande($id) {

	$criteria=new CDbCriteria(array('condition'=>'id='.$id));

    $dataProvider = new CActiveDataProvider('Beneficaire', array(
            'criteria'=>$criteria,
    ));
		$this->render('analyseDemande', array(
			'dataProvider' => $dataProvider,
		));

		
	}

	public function actionLunette($id) {

	$criteria=new CDbCriteria(array('condition'=>'id='.$id));

    $dataProvider = new CActiveDataProvider('Beneficaire', array(
            'criteria'=>$criteria,
    ));
		$this->render('lunette', array(
			'dataProvider' => $dataProvider,
		));

		
	}
	 public function actionGenerateExcel()
	{
            $session=new CHttpSession;
            $session->open();		
            
             if(isset($session['Beneficaire_records']))
               {
                $model=$session['Beneficaire_records'];
               }
               else
                 $model = Beneficaire::model()->findAll();

		
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

             if(isset($session['Beneficaire_records']))
               {
                $model=$session['Beneficaire_records'];
               }
               else
                 $model = Beneficaire::model()->findAll();



		$html = $this->renderPartial('expenseGridtoReport', array(
			'model'=>$model
		), true);
		
		//die($html);
		
		$pdf = new TCPDF();
		$pdf->SetCreator(PDF_CREATOR);
		$pdf->SetAuthor(Yii::app()->name);
		$pdf->SetTitle('Beneficaire Report');
		$pdf->SetSubject('Beneficaire Report');
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
		$pdf->Output("Beneficaire_002.pdf", "I");
	}
	
}