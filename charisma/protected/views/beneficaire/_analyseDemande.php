
<?php
$hospital = '';
if(isset(Yii::app()->session['iduser'])){

 $hospital = Yii::app()->db->createCommand()
    ->select('hopitalName')
    ->from('hospital')
    ->where('iduser=:id', array(':id'=>Yii::app()->session['iduser']))
    ->queryScalar();

     $row = Yii::app()->db->createCommand()
    ->select('cardnumber,a.firstname,a.middlename,a.lastname')
    ->from('members a ,beneficaire b')
    ->where(' a.id=b.idmember and b.id=:id', array(':id'=>$_GET['id']))
    ->queryRow();
}



$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
    array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
    array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/admin'), 'linkOptions'=>array()),
    array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/index'), 'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2,'linkOptions'=>array()),
    array('label'=>'Formulaire des sois du patient', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/formulaire',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
    array('label'=>'Ordonnance Medicale', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/ordonnanceMedicale',array('id'=>$_GET['id'])), 'visible'=>Yii::app()->user->groupe!=2,'linkOptions'=>array()),
    array('label'=>'Medical spectacle prescription', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/lunette',array('id'=>$_GET['id'])), 'visible'=>Yii::app()->user->groupe!=2,'linkOptions'=>array()),
    array('label'=>'Bullettin d\'analyse', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/analyseDemande',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2,'active'=>true, 'linkOptions'=>array()),
    array('label'=>'Print', 'icon'=>'icon-print', 'url'=>'javascript:void(0);return false', 'linkOptions'=>array('onclick'=>'printDiv();return false;')),

		),
));
$this->endWidget();


$birthday_timestamp = strtotime($data->dateofbirth);  
// Calculates age correctly
// Just need birthday in timestamp
$age = date('md', $birthday_timestamp) > date('md') ? date('Y') - date('Y', $birthday_timestamp) - 1 : date('Y') - date('Y', $birthday_timestamp);
  ?>
</hr>
<div class='printableArea'>
<table width="80%" align='center' border=0>
	<tr> 
		 <td>
          <p>
            University of Rwanda Medical Insurance Scheme<br/>
            Mutuelle de Sante de l'Universite du Rwanda<br/>
            B.P. HI-TEL: 531031<br/>
            HUYE
          </p>
		 </td>
	</tr>

	<tr> 
		 <td colspan=3> <h2>
		 	<center>BULLETIN DE DEMANDE D' ANALYSE N° </center>
		 </h2></td>
	</tr>

	<tr> 
		 <td><h4>Identification</h4></br></td>
	</tr>

	<tr> 
		 <td>
            <ul>
              <ul>
              <li>HOPITAL DE : <b><?php echo $hospital;?><b></li>
              <li>NON DU MALADE: <b><?php echo CHtml::encode($data->firstname); ?> <?php echo CHtml::encode($data->middlename); ?> <?php echo CHtml::encode($data->lastname); ?></li></b>
              <li>NUMERO ET CATEGORIE DU MALADE:<b><?php echo $row['cardnumber']; ?></li></b>
              <li>NOM DU MEMBRE PRINCIPAL : <b><?php echo $row['firstname'].' '.$row['middlename'].' '.$row['lastname']; ?></li></b></li>
              <li>DATE D' ADMISSION : <b><?php echo date('d-m.Y');?><b></li>
              <li>DATE DE SORTIE :</li>
              <li>SERVICE DE :</li>
               <li>BENEFICIAIRE : <b><?php echo CHtml::encode($data->firstname); ?> <?php echo CHtml::encode($data->middlename); ?> <?php echo CHtml::encode($data->lastname); ?></b></li>
            </ul>
		 </td>
	</tr>
<tr><td colspan=3><center><h3>Prescription</h3></center> </td></tr>
	<tr> 
		 <td colspan=3>
            <table border=0 width=100%> 
               
               <tr >
               	<td colspan=3 align='left'><b><u>Analyses demandes</u></b></td>
               </tr>
               <tr height="200px">
               	<td colspan=3>&nbsp;</td>
              
               </tr>
               <tr >
               	<td >CoutTotal:</td>
               	 <td colspan=2>&nbsp;</td>
               	</tr>
                <tr >
               	<td>15%</td>
               	 <td colspan=2>Fait a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le </td>
               	</tr>
                <tr>
               	<td>85%</td>
               	 <td colspan=2>Nom du medecin</td>
               	</tr>
            </table>
		 </td>
	</tr>

    <tr>
         <td colspan=2 align='center'><br/></br>Signature et Cachet</td>
          
<table>

</div>
<style type="text/css" media="print">
body {visibility:hidden;}
.printableArea{visibility:visible;} 
</style>
<script type="text/javascript">
function printDiv()
{

window.print();

}
</script>


